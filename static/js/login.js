var gpwd_set = new Set();
var pswd1='';


function check_email()
{
    var x=document.getElementById("prompt1");
    var y=document.getElementById("prompt2");
    
    if (document.getElementById('email').value=="") {
        x.innerHTML='Please enter email id!';
        x.style.color='red';
    }

    else
    {
        x.innerHTML='';
        y.innerHTML='';
        $.ajax({
            url : "shuffle_img",
            type : "POST",
            data : {
                email : document.getElementById('email').value,
            csrfmiddlewaretoken: csrf_token , //This is must for security in Django
            }, // data sent with the post request

            // handle a successful response
            success : function(response){
                $('.grid-container').html('').wrapInner(response);
            },

            error : function(response){
                
                window.location.href='register';
            }
        });
        timer();
    }
}

function nxt()
    {
        document.getElementById('next').hidden=true;
        document.getElementById('login').hidden=false;
        document.getElementById('images').hidden=false;

    check_email();
}


//submission part
function post(path, params, method = 'post') {

    // The rest of this code assumes you are not using a library.
    // It can be made less wordy if you use one.
    const form = document.getElementById('login_form');
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

var form = document.getElementById('login_form');
form.addEventListener('submit', function (event) {
    event.preventDefault();
    
    post('login_page', {
        email: document.getElementById('email').value,
        password: Array.from(gpwd_set),
    })
});