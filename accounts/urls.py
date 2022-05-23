
from django.contrib import admin
from django.urls import path , include
from accounts import views
from django.contrib.auth import views as auth_views
from django.contrib.auth.views import PasswordResetView 

# from .forms import CustomPasswordResetForm

urlpatterns = [
    path('',views.login,name='login'),
    path('about',views.about,name='about'),
    path('login',views.login,name='login'),
    path('dashboard',views.dashboard,name='dashboard'),
    path('index',views.index,name='index'),
    path('register',views.register,name='register'),
    path('handle_register',views.handle_register,name='handle_register'),
    path('check_email',views.check_email,name='check_email'),
    path('new_random_img',views.new_random_img,name='new_random_img'),
    path('shuffle_img',views.shuffle_img,name='shuffle_img'),
    path('shuffle_login_img',views.shuffle_login_img,name='shuffle_login_img'),
    path('login_mail_check',views.login_mail_check,name='login_mail_check'),
    path('login_page',views.login_page,name='login_page'),
    path('logout',views.handlelogout,name='handlelogout'),
    path('change_user_password', views.change_user_password,name='change_user_password'),
    path('sendPasswordResetLinkToUser', views.sendPasswordResetLinkToUser,name='sendPasswordResetLinkToUser'),
    path('reset_password',views.reset_password,name='reset_password'),
    path('reset/<str:uid>', views.reset_from_uid, name='reset_uid'),

    path('reset_password_sent/', 
        auth_views.PasswordResetDoneView.as_view(template_name="password_reset_sent.html"), 
        name="password_reset_done"),

    # path('reset/<uidb64>/<token>/',
    #  auth_views.PasswordResetConfirmView.as_view(template_name="password_reset_form.html"), 
    #  name="password_reset_confirm"),

    # path('reset_password_complete/', 
    #     auth_views.PasswordResetCompleteView.as_view(template_name="password_reset_done.html"), 
    #     name="password_reset_complete"),
]
