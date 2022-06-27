from django.contrib import admin
from accounts.models import LoginInfo
from accounts.models import Contact
# Register your models here.

admin.site.register(LoginInfo)

admin.site.register(Contact)