var gpwd_set = new Set();
var pswd1 = '';
var pswd2 = '';
var y=document.getElementById("y");
function func1(event)
{
    event.preventDefault();
    pswd1 = '';
    pswd2 = '';
    $('.grid-container').html('').load(
        "new_random_img"
    );
}


function conf_img()
{
    enable_button();
    shuffle();
}



function shuffle() {
    
    
    if (gpwd_set.size<3)
    {
        y.innerHTML = "please select at least 3 images";
        y.style.color='red';
    }
    else
    {
        y.innerHTML='';
        pswd1 = Array.from(gpwd_set);
        gpwd_set.clear();
        
        document.getElementById('reload_image').hidden = true;
        document.getElementById('confirm_image').hidden = true;
        document.getElementById('register_btn').hidden = false;
        document.getElementById('info').innerHTML = 'now select any three images and remember their order. that will be your password!';
        event.preventDefault();
        $('.grid-container').html('').load(
            "shuffle_img"
        );
        timer();
    }

}




function check_email(event) {
    $.ajax({
        url: "shuffle_img",
        type: "POST",
        data: {
            email: '{{user.email}}',
            csrfmiddlewaretoken: csrf_token, //This is must for security in Django
        }, // data sent with the post request

        // handle a successful response
        success: function (response) {
            $('.grid-container').html('').wrapInner(response);
        },

        error: function (response) {

            window.location.href = 'register';
        }
    });

    timer();
}


function nxt() {
    
    var t = pass_check();
    
    if(t!=false)
    {
        document.getElementById('next').hidden = true;
        document.getElementById('reset_pswd').hidden = false;
        disable_button();
        gpwd_set = new Set();
        document.getElementById("head_pass").innerHTML="New Password:";
        y.innerHTML='';
    }
    else
    {
        gpwd_set = new Set();
        $('.grid-container').html('').load(
            "shuffle_img"
        );
        timer();
    }
}



function pass_check() {
    
    var f=0;
    
    $.ajax({
        url: "check_pass",
        type: "POST",
        async: false,
        data: {
            password1 : Array.from(gpwd_set),
            csrfmiddlewaretoken: csrf_token, //This is must for security in Django
        }, // data sent with the post request

        // handle a successful response
        success: function (response) {
            $('.grid-container').html('').wrapInner(response);
        },

        error: function (response) {
            y.innerHTML="incorrect password ";
            
            f=1;
        }
    });
    if(f==1) return false;
}
//submission part
function post(path, params, method = 'post') {

    // The rest of this code assumes you are not using a library.
    // It can be made less wordy if you use one.
    const form = document.getElementById('reset_pass_form');
    form.method = method;
    form.action = path;
    

    for (const key in params) {
        if (params.hasOwnProperty(key)) {
            const hiddenField = document.createElement('input');
            hiddenField.type = 'hidden';
            hiddenField.name = key;
            hiddenField.value = params[key];
            form.appendChild(hiddenField);
        }
    }
    document.body.appendChild(form);
    form.submit();
}

var form = document.getElementById('reset_pass_form');
form.addEventListener('submit', function (event) {
    event.preventDefault();
    
    post('change_user_password', {
        password1: pswd1,
        password2: Array.from(gpwd_set),
    })
});
