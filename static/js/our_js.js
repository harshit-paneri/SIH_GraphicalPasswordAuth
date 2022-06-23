var gpwd_set = new Set();
        var pswd1='';
        var pswd2='';

function onSelect(r,c) {
    var imagesList = document.getElementsByClassName('img_btn');
    var x=imagesList[2].disabled;
    var res = r.toString() + c.toString();
    if(!x)
    {
        if (gpwd_set.has(res) ) {
            gpwd_set.delete(res);
            document.getElementById(res).style.opacity=1;
        } else {
                gpwd_set.add(res);
                document.getElementById(res).style.opacity=0;
        }
}
}



function haltFunction() {
    clearInterval(timeValue);
 }
function startTimer(duration, display) {
    var timer = duration;
    timeValue = setInterval(function () {
        seconds = parseInt(timer);
        disable_button();
        seconds = seconds < 10 ? "0" + seconds : seconds;
        display.textContent = 'in '+ seconds + " second , images will become blur!";

        if (timer==0){
            enable_button();
            
        blur_img(); haltFunction(); return;}
        --timer;

    }, 1000);
    return ;
}

function timer(){
    var fiveMinutes = 10,
        display = document.querySelector('#time');
    startTimer(fiveMinutes, display);
};


function blur_img()
        {
            var imagesList = document.getElementsByClassName('grid-img');
            for(var i=0;i<imagesList.length;i++)
            {
                imagesList[i].style.filter = 'blur(5px)';
            }
        }

    
        window.onload = function(e){ 
            enable_button(); 
        }



        //submission part
        function post(path, params, method = 'post') {

            // The rest of this code assumes you are not using a library.
            // It can be made less wordy if you use one.
            const form = document.getElementById('my_form');
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

        // Submit post on submit
    var form = document.getElementById('my_form');
    form.addEventListener('submit', function (event) {
        event.preventDefault();
        
        post('check_email', {
            email: document.getElementById('email').value,
            password1: pswd1,
            password2: Array.from(gpwd_set),
        })
    });
   