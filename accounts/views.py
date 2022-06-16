
from django.contrib.auth.hashers import check_password
from django.shortcuts import render
from django.shortcuts import render , redirect
from django.http import HttpResponseRedirect 
from django.contrib.auth.models import User

from accounts.models import LoginInfo 
from django.contrib import messages
from django.core.mail import EmailMessage
from GraphicalPasswordAuth.settings import  TBA, EMAIL_HOST_USER, ALLOWED_HOSTS

from django.contrib.auth import authenticate ,login as auth_login , logout , update_session_auth_hash
from django.contrib.auth.forms import PasswordChangeForm , SetPasswordForm
from GraphicalPasswordAuth.settings import STATICFILES_DIRS
import os
import random , uuid
import numpy as np
from .forms import CustomPasswordResetForm

# Create your views here.
def index(request):
    return redirect(login)

def dashboard(request):
    return render(request,'dashboard.html')

def about(request):
    return render(request,'about.html')

def login(request):
    if request.user.is_authenticated:
            return redirect(dashboard)
    else:
        return render(request, 'login.html')
    
    
def register(request):
    if request.user.is_authenticated:
        return redirect(index)
    else:
        static_path=STATICFILES_DIRS[0]
        images=str(static_path)+"\dataset"
        imgs=os.listdir(images)
        image_name=random.choice(imgs)
        context={
            'img_name':image_name[:-4]
        }
        request.session['img_name']=image_name[:-4]
        return render(request, 'register.html',context)
    
    
def handle_register(request):
    print(request.method)
    if request.method == "POST":
        email_id=request.POST['email']
    return render(request,'login.html')


def get_img_name():
    static_path=STATICFILES_DIRS[0]
    images=str(static_path)+"\dataset"
    imgs=os.listdir(images)
    image_name=random.choice(imgs)
    
    return image_name

def new_random_img(request):
    img_name=get_img_name()
    context={
        'img_name':img_name[:-4]
    }
    
    request.session['img_name']=img_name[:-4]
    if request.is_ajax:
        return render(request,'grid.html',context)
        
def shuffle_img(request):
    print(request.session)
    x = np.arange(1,10)
    np.random.shuffle(x)
    try:
        if request.session['img_name']:  
            context={
                'img_name':request.session['img_name'],
                'shuffle':x
            }
    except:
        user=User.objects.get(username=request.user)
        context={
            'img_name':user.logininfo.image_name,
            'shuffle':x
        }
        
    if request.is_ajax:
            return render(request,'grid.html',context)
        
        
def shuffle_login_img(request):
    print(request.POST)
    import numpy as np
    x = np.arange(1,10)
    np.random.shuffle(x)
    email = request.POST['email']
    if email in User.objects.all().values_list('email', flat=True):
        user = User.objects.get(username=request.POST['email'])
        print(user.logininfo.image_name)
        data={
            "img_name":str(user.logininfo.image_name),
            'shuffle':x
        }
        return render(request,'grid.html',context=data)
    else:
        messages.error(request,"account does not exists!")
        return False
        
def check_email(request):
    if request.method == 'POST':
        email = request.POST['email']
        password1 = request.POST['password1']
        password2 = request.POST['password2']
        if password1==password2:
            password1=''.join(password1)
            password2=''.join(password2)
            img_name=(password1.split(','))[0][:-1]
            print(img_name)
            print(password1)
            if email in User.objects.all().values_list('email', flat=True):
                messages.error(request,'User already exists!')
                return redirect(login)
            try:
                # create user and loginInfo for him
                user = User.objects.create_user( username=email, email=email, password=password1)
                login_info = LoginInfo(user=user, fails=0,image_name=img_name)
                login_info.save()
                auth_login(request,user)
                
                messages.success(request, 'Account created successfully!')
            except Exception as e:
                print(e)
                messages.warning(request, 'Error while creating Account!')
                return redirect(register)
            return redirect(login)
        else:
            messages.error(request, 'passwords does not match!')
            return render(request, 'register.html')
        

def sendLoginLinkMailToUser(username):
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
        print('LOGIN LINK EMAIL SENT')


def reset_password(request):
    fm=CustomPasswordResetForm()
    context={
        'form':fm,
    }
    return render(request,'password_reset.html',context)


def sendPasswordResetLinkToUser(request):

    # send reset link everytime user requests
    try:
        user = User.objects.filter(username=request.POST['email']).first()
        if user==None:
            messages.error(request, 'user does not exist!')
            return redirect(index)
    except Exception as e:
        print(e)
        return False
    
    link = str(uuid.uuid4())
    user.logininfo.reset_link = link
    user.logininfo.save()
    print("here")
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
    print('PWD RESET LINK EMAIL SENT')
    return render(request,'password_reset_sent.html')


        
def update_login_info(user, didSuccess):
    if didSuccess:
        user.logininfo.fails = 0
    else:
        user.logininfo.fails += 1
    
    user.logininfo.save()
    print('{} Failed attempts: {}'.format(user.username, user.logininfo.fails))


def isBlocked(username):
    try:
        user = User.objects.get(username=username)
    except Exception:
        return None
    print('isBlocked: {} - {}'.format(user.logininfo, TBA))
    if user.logininfo.fails >= TBA:
        return True
    else:
        return False
        
        
def login_page(request):
    
    print("inside login_page")
    if request.method == 'POST':
        username = request.POST['email']
        password = request.POST['password']
        
        password=''.join(password)
        print(username, password)

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
                messages.warning(request, 'Login Failed! inavlid password!')
                context = {
                        'email' : user.email,
                    }
                return render(request, 'login.html',context)

    else:
        return render(request,'login.html')


def login_mail_check(request):
    email = request.POST['email']
    if email in User.objects.all().values_list('email', flat=True):
        user = User.objects.get(username=request.POST['email'])
        print(user.logininfo.image_name)
        data={
            "img_name":str(user.logininfo.image_name)
        }
        return render(request,'login.html',context=data)
    else:
        messages.error("account does not exists!")
        return redirect(register)
    
    
def handlelogout(request):
    logout(request)
    messages.success(request, 'Successfully logged Out.')
    return redirect('index')






def change_user_password(request):
    if request.user.is_authenticated:  
        if request.method =="POST":
            password1 = request.POST['password1']
            password2 = request.POST['password2']
            if password1==password2:
                password1=''.join(password1)
                password2=''.join(password2)
                img_name=(password1.split(','))[0][:-1]
                print(img_name)
                print(password1)
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
            pass
        return render(request, 'change_user_password.html')
    else:
        return redirect('login')
    
    
    
    
def check_pass(request):
    print("inside check pass function")
    passw=request.POST.getlist('password1[]')
    passw=','.join(passw)
    res=check_password(passw,request.user.password)
    if res:
       return new_random_img(request)
    else:
        return False
    
def reset_from_uid(request,uid):
    if request.method == 'POST':
        print('hi-post')
        password = request.POST['password1']
        print(password)
        uniqui_id=uid
        print(uniqui_id)
        try:
            # get user from the uid and reset the Link to 'NO_LINK' again
            login_info = LoginInfo.objects.get(reset_link=uid)
            
            print(login_info)
            user = login_info.user
            # reset pwd
            user.set_password(password)
            login_info.reset_link = None
            login_info.image_name=request.session['img_name']
            login_info.save()
            user.save()
            print(user)
            messages.success(request, 'Password Changed Successfully!')
        except Exception as e:
            print(e)
            messages.warning(request, 'Invalid Link. Please check again!')
        return redirect(index)
    else:
        print('hi-else')
        try:
            # To make sure the link is valid
            print(uid)
            login_info = LoginInfo.objects.get(reset_link=uid)
            print(login_info)
            data = {
                'img_name': get_img_name()[:-4],
            }
            print(data['img_name'])
            request.session['img_name']=data['img_name']
            return render(request, 'password_reset_form.html', context=data)
        except Exception:
            messages.warning(request, 'Invalid Link. Please check again!')
            return redirect(index)
        
        
        
def login_from_uid(request, uid):
    try:
        # get user from the uid and reset the Link to 'NO_LINK' again
        print('uid = ',uid)
        login_info = LoginInfo.objects.get(login_link=uid)
        print(login_info.user)
        user = login_info.user
        # auth_login(request, user)
        update_login_info(user, True)
        login_info.login_link = None
        login_info.save()
        messages.success(request, 'Account Unlocked. Please login again!')
    except Exception:
        messages.warning(request, 'Invalid Link. Please check again!')

    return redirect('index')


def del_user(request):
    uname=str(request.user)
    user=User.objects.get(username=request.user)
    print(user)
    if user==None:
        messages.error(request,"User does not exist!")
    else:
        user.delete()
        messages.success(request,"user {} deleted successfully!".format(uname))
    return redirect('index')
