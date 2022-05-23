import imp
from django.contrib import admin
from django.urls import path , include
from accounts import views

urlpatterns = [
    path('',views.login,name='login'),
    path('about',views.about,name='about'),
    path('login',views.login,name='login'),
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
]
