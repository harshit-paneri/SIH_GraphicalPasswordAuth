from django.db import models

# Create your models here.
class user_accounts(models.Model):
    email=models.EmailField(max_length=200,primary_key=True)
    user_pass=models.CharField(max_length=200,null=False)