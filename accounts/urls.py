from django.urls import path
from accounts import views
from django.contrib.auth import views as auth_views 

urlpatterns = [
    path('',views.login,name='login'),
    path('about',views.about,name='about'),
    path('contactus',views.contactus,name='contactus'),
    path('login',views.login,name='login'),
    path('dashboard',views.dashboard,name='dashboard'),
    path('index',views.index,name='index'),
    path('register',views.register,name='register'),
    path('check_email',views.check_email,name='check_email'),
    path('new_random_img',views.new_random_img,name='new_random_img'),
    path('shuffle_img',views.shuffle_img,name='shuffle_img'),
    path('login_page',views.login_page,name='login_page'),
    path('logout',views.handlelogout,name='logout'),
    path('change_user_password', views.change_user_password,name='change_user_password'),
    path('check_pass', views.check_pass,name='check_pass'),
    path('sendPasswordResetLinkToUser', views.sendPasswordResetLinkToUser,name='sendPasswordResetLinkToUser'),
    path('reset_password',views.reset_password,name='reset_password'),
    path('reset/<str:uid>', views.reset_from_uid, name='reset_from_uid'),
    path('login/<str:uid>', views.login_from_uid, name='login_uid'),
    path('del_user', views.del_user, name='del_user'),

    path('reset_password_sent/', 
        auth_views.PasswordResetDoneView.as_view(template_name="password_reset_sent.html"), 
        name="password_reset_done"),
]
