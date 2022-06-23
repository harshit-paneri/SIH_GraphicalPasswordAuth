function disable_button() {
    var imagesList = document.getElementsByClassName('img_btn');
    for (var i = 0; i < imagesList.length; i++) {
        imagesList[i].disabled = true;
    }
}


function enable_button() {
    var imagesList = document.getElementsByClassName('img_btn');
    for (var i = 0; i < imagesList.length; i++) {
        imagesList[i].disabled = false;
    }
}


function blur_img() {
    var imagesList = document.getElementsByClassName('grid-img');
    for (var i = 0; i < imagesList.length; i++) {
        imagesList[i].style.filter = 'blur(5px)';
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
        display.textContent = 'in ' + seconds + " seconds , images will become blur!";

        if (timer == 0) {
            enable_button();

            blur_img(); haltFunction(); return;
        }
        --timer;

    }, 1000);
    return;
}

function timer() {
    var fiveMinutes = 10,
        display = document.querySelector('#time');
    startTimer(fiveMinutes, display);
}


function onSelect(r, c) {
    var imagesList = document.getElementsByClassName('img_btn');
    var x = imagesList[2].disabled;
    var res = r.toString() + c.toString();
    if (!x) {
        if (gpwd_set.has(res)) {
            gpwd_set.delete(res);
            document.getElementById(res).style.opacity = 1;
        } else {
            gpwd_set.add(res);
            document.getElementById(res).style.opacity = 0;
        }
    }
}