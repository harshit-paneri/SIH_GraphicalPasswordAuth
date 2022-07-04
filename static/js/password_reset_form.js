


// function func1() {
//     console.log("inside func1 new random image");
//     $('.grid-container').html('').load('new_random_img');
// }

function func1()
{
    $('.grid-container').html('').load(
        'new_random_img'
    );
}


var gpwd_set = new Set();
var pswd1 = '';
var pswd2 = '';

function shuffle(event) {
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




function check_email(event) {
    var x = document.getElementById("prompt1");
    var y = document.getElementById("prompt2");

    if (gpwd_set.size < 3) {
        y.innerHTML = "please select at least 3 images";
        y.style.color = 'red';
    }

    else {
        x.innerHTML = '';
        y.innerHTML = '';
        shuffle(event);
        timer();
    }
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
    var uid = window.location.href.split("/").pop();


    post(`${uid}`, {
        password1: pswd1,
        password2: Array.from(gpwd_set),
    })
});

