from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class user_accounts(models.Model):
    email=models.EmailField(max_length=200,primary_key=True)
    unique_image=models.CharField(max_length=250)
    user_pass=models.CharField(max_length=200,null=False)
    
    def __str__(self):
        return self.email
    


class LoginInfo(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    image_name=models.CharField(max_length=200,default='lion')
    fails = models.PositiveSmallIntegerField(default=0)
    login_link = models.CharField(unique=True, blank=True, null=True, max_length=225)
    reset_link = models.CharField(unique=True, blank=True, null=True, max_length=225)

    def __str__(self):
        return self.user.username