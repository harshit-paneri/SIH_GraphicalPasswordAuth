from django.contrib.auth import views as auth_views
from django.contrib import messages
from django import forms

from django.contrib.auth.forms import PasswordResetForm
from django.contrib.auth.models import User

class CustomPasswordResetForm(forms.Form):
    email = forms.EmailField(max_length=100)
    
    def clean_email(self):
        email = self.cleaned_data['email']
        
        all_emails=list(User.objects.all().values_list('email', flat=True))
        if email not in all_emails:
            # raise messages.warning(request, 'Do no Spam Other Emails!!')
            raise forms.ValidationError('Do not Spam Other Emails!!',code='invalid')
        
        return email
