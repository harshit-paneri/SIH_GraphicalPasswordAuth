from django.db import models
from django.contrib.auth.models import User

# Create your models here.

class LoginInfo(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    image_name=models.CharField(max_length=200,default='lion')
    fails = models.PositiveSmallIntegerField(default=0)
    login_link = models.CharField(unique=True, blank=True, null=True, max_length=225)
    reset_link = models.CharField(unique=True, blank=True, null=True, max_length=225)

    def __str__(self):
        return self.user.username

class Contact(models.Model):
    firstname = models.CharField(max_length=122)
    lastname = models.CharField(max_length=122)
    contactemail = models.EmailField(max_length=122)
    comment = models.TextField()
    def __str__(self):
        return self.contactemail