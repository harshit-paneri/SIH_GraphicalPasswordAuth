from django.contrib.auth.hashers import check_password
from django.shortcuts import render , redirect
from django.contrib.auth.models import User
from accounts.models import LoginInfo 
from django.contrib import messages
from django.core.mail import EmailMessage
from GraphicalPasswordAuth.settings import  TBA, EMAIL_HOST_USER, ALLOWED_HOSTS
from django.contrib.auth import authenticate ,login as auth_login , logout
from GraphicalPasswordAuth.settings import STATICFILES_DIRS
import os , random , uuid , numpy as np
from .forms import CustomPasswordResetForm

from accounts.models import Contact


# Create your views here.
def index(request):      #main landing index page ( default )
    return redirect(login)

def dashboard(request):
    return render(request,'dashboard.html')

def about(request):
    return render(request,'about.html')

def contactus(request):
    if request.method == "POST":
        Firstname = request.POST.get('firstname')
        Lastname = request.POST.get('lastname')
        Email = request.POST.get('contactemail')
        Comments = request.POST.get('comment')
        contactus_instance = Contact( firstname=Firstname, lastname=Lastname, contactemail= Email, comment= Comments  )
        contactus_instance.save()
        return redirect(contactus)

    return render(request,'contactus.html')

def login(request):
    if request.user.is_authenticated:
            return redirect(dashboard)
    else:
        return render(request, 'login.html')
    
def get_img_name():     #function to get a random image
    static_path=STATICFILES_DIRS[0]
    images=str(static_path)+"\dataset"
    imgs=os.listdir(images)
    image_name=random.choice(imgs)
    return image_name
    
def register(request):     #register page redirection
    if request.user.is_authenticated:
        return redirect(index)
    else:
        image_name=get_img_name()
        context={
            'img_name':image_name[:-4]
        }
        request.session['img_name']=image_name[:-4]
        return render(request, 'register.html',context)
    



def new_random_img(request):     #function to get new random image , when requesting for another image 
    img_name=get_img_name()
    context={
        'img_name':img_name[:-4]
    }
    request.session['img_name']=img_name[:-4]
    
    return render(request,'grid.html',context)
        
        
        
def shuffle_img(request):   #function to shuffle the current image and populate image grid
    x = np.arange(1,10)
    np.random.shuffle(x)
    
    if request.user.is_authenticated and request.method=="POST":
        user = User.objects.get(username=request.user)
        context={
                'img_name':user.logininfo.image_name,
                'shuffle':x
            }
        
    else:
        try:    
            email = request.POST['email']
            if email in User.objects.all().values_list('email', flat=True):
                user = User.objects.get(username=request.POST['email'])
           
            data={
                "img_name":str(user.logininfo.image_name),
                'shuffle':x
            }
            return render(request,'grid.html',context=data)
        except:
            if request.session['img_name']:
                context={
                    'img_name':request.session['img_name'],
                    'shuffle':x
                }
            else:
                messages.error(request,"account does not exists!")
                return False

        
    return render(request,'grid.html',context)
        

        
        
        
def check_email(request):    #function to check the email and then proceeding with account creation ( registration ) 
    if request.method == 'POST':
        email = request.POST['email']      #extract email
        password1 = request.POST['password1']    #extract pass1 unshuffled image
        password2 = request.POST['password2']    #extract pass2 shuffled image
        if len(password1)<5:
            messages.error(request, 'Invalid password!')
            return redirect(register)
        if password1==password2:
            password1=''.join(password1)
            password2=''.join(password2)
            img_name=(password1.split(','))[0][:-1]
    
            if email in User.objects.all().values_list('email', flat=True):
                messages.error(request,'User already exists!')
                return redirect(login)
            try:
                # create user and loginInfo for him
                user = User.objects.create_user( username=email, email=email, password=password1)    #creating user in database
                login_info = LoginInfo(user=user, fails=0,image_name=img_name)                       #filling login details
                login_info.save()
                auth_login(request,user)
                messages.success(request, 'Account created successfully!')
                
                
            except Exception as e:
                messages.warning(request, 'Error while creating Account!')
                return redirect(register)
            return redirect(login)
        
        else:
            messages.error(request, 'passwords does not match!')
            return redirect(register)
        

def sendLoginLinkMailToUser(username):    # login when account is blocked!
    user = User.objects.get(username=username)
    # send email only if user.logininfo.login_link is not None
    if user.logininfo.login_link is None:
        link = str(uuid.uuid4())
        user.logininfo.login_link = link
        user.logininfo.save()
        email = EmailMessage(
            subject='Link to Log in to your account',
            body='''
            Someone tried to bruteforce on your account.
            Click the Link to Login to your account directly.
            The link is one-time clickable
            link: http://{}:8000/login/{}
            '''.format(ALLOWED_HOSTS[-1], link), # might wanna change the allowd_host
            from_email=EMAIL_HOST_USER,
            to=[user.email],
        )
        email.send()


def reset_password(request):   #function to display password reset form
    fm=CustomPasswordResetForm()
    context={
        'form':fm,
    }
    return render(request,'password_reset.html',context)


def sendPasswordResetLinkToUser(request):  #function to send Password reset link to the user. Forgotten password.
    # send reset link everytime user requests
    try:
        user = User.objects.filter(username=request.POST['email']).first()
        if user==None:
            messages.error(request, 'user does not exist!')
            return redirect(index)
        
    except Exception as e:
        return False
    
    link = str(uuid.uuid4())
    user.logininfo.reset_link = link
    user.logininfo.save()
    email = EmailMessage(
        subject='Link to Rest your Password',
        body='''
        You have requested to reset your password.
        Click the Link to reset your password directly.
        The link is one-time clickable
        link: http://{}:8000/reset/{}
        '''.format(ALLOWED_HOSTS[-1], link), # might wanna change the allowd_host
        from_email=EMAIL_HOST_USER,
        to=[user.email],
    )
    email.send()
    return render(request,'password_reset_sent.html')


        
def update_login_info(user, didSuccess):    #updating user login details everytime
    if didSuccess:
        user.logininfo.fails = 0
    else:
        user.logininfo.fails += 1
    
    user.logininfo.save()
    # print('{} Failed attempts: {}'.format(user.username, user.logininfo.fails))


def isBlocked(username):   #checks whether user is blocked or not
    try:
        user = User.objects.get(username=username)
    except Exception:
        return None
    # print('isBlocked: {} - {}'.format(user.logininfo, TBA))
    if user.logininfo.fails >= TBA:
        return True
    else:
        return False
        
        
def login_page(request):    #login page display function . handles login
    if request.method == 'POST':
        username = request.POST['email']
        password = request.POST['password']
        
        password=''.join(password)
        # print(username, password)

        block_status = isBlocked(username)
        if block_status is None:
            # No user exists
            messages.warning(request, 'Account doesn\'t Exist')
            return redirect('login')

        elif block_status == True:
            # Blocked - send login link to email
            # check if previously sent, if not send
            sendLoginLinkMailToUser(username)
            messages.warning(request, 'Your account is Blocked, please check your Email!')
            return redirect('login')
        else:
            # Not Blocked
            user = authenticate(username=username, password=password, request=request)
            if user is not None:
                auth_login(request, user)
                update_login_info(user, True)
                messages.success(request, 'Login successfull!')
                return redirect('index')
            else:
                user = User.objects.get(username=username)
                update_login_info(user, False)
                messages.warning(request, 'Login Failed! inavlid password! {} attempts left '.format(TBA - int(user.logininfo.fails)))
                context = {
                        'email' : user.email,
                    }
                return render(request, 'login.html',context)

    else:
        return render(request,'login.html')

    
    
def handlelogout(request):   #logout user
    logout(request)
    messages.success(request, 'Successfully logged Out.')
    return redirect('index')


def change_user_password(request):      #when user wants to reset password from within account
    if request.user.is_authenticated:  
        if request.method =="POST":
            password1 = request.POST['password1']
            password2 = request.POST['password2']
            if password1==password2:
                password1=''.join(password1)
                password2=''.join(password2)
                img_name=(password1.split(','))[0][:-1]

                u=User.objects.get(username=request.user)
                u.set_password(password1)
                u.save()
                l=LoginInfo.objects.get(user_id=u.id)
                l.image_name=img_name
                l.save()
                messages.success(request,"Password changed successfully!");
                auth_login(request,u)
                return redirect(dashboard)
            else:
                messages.error(request,'passwords do not match!!')
                return render(request, 'change_user_password.html')
        else:
            return render(request, 'change_user_password.html')
    else:
        return redirect('login')
    
    
    
    
def check_pass(request):        #checking current password
    print(request)
    passw=request.POST.getlist('password1[]')
    passw=','.join(passw)
    res=check_password(passw,request.user.password)
    if res:
       return new_random_img(request)
    else:
        return False
    
def reset_from_uid(request,uid):
    if request.method == 'POST':
        password = request.POST['password1']
        try:
            # get user from the uid and reset the Link to 'NO_LINK' again
            login_info = LoginInfo.objects.get(reset_link=uid)
            user = login_info.user
            # reset pwd
            user.set_password(password)
            login_info.reset_link = None
            login_info.image_name=request.session['img_name']
            login_info.save()
            user.save()
            messages.success(request, 'Password Changed Successfully!')
        except Exception as e:
            messages.warning(request, 'Invalid Link. Please check again!')
        return redirect(index)
    else:
        try:
            # To make sure the link is valid
            
            login_info = LoginInfo.objects.get(reset_link=uid)
            
            data = {
                'img_name': get_img_name()[:-4],
            }
            request.session['img_name']=data['img_name']
            return render(request, 'password_reset_form.html', context=data)
        except Exception:
            messages.warning(request, 'Invalid Link. Please check again!')
            return redirect(index)
        
        
        
def login_from_uid(request, uid):
    try:
        # get user from the uid and reset the Link to 'NO_LINK' again
        login_info = LoginInfo.objects.get(login_link=uid)
        user = login_info.user
        # auth_login(request, user)
        update_login_info(user, True)
        login_info.login_link = None
        login_info.save()
        messages.success(request, 'Account Unlocked. Please login again!')
    except Exception:
        messages.warning(request, 'Invalid Link. Please check again!')

    return redirect('index')


def del_user(request):   #delete user account
    uname=str(request.user)
    user=User.objects.get(username=request.user)
    if user==None:
        messages.error(request,"User does not exist!")
    else:
        user.delete()
        messages.success(request,"user {} deleted successfully!".format(uname))
    return redirect('index')
