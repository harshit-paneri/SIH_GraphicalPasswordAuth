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

function sleep(milliseconds) {
    var start = new Date().getTime();
    for (var i = 0; i < 1e7; i++) {
      if ((new Date().getTime() - start) > milliseconds){
        break;
      }
    }
  }

// let images = ['0','1.jpg', '2.jpg', '3.jpg'];

// let index = 1;

// function display_image_count(r1,index) {
//     var imgElement = document.getElementById(r1);
//     const prev_img_src= imgElement.src;
//     console.log(count_src+images[index]);
//     var new_url = new String(count_src+images[index]) ;

//     console.log(imgElement.src);
//     sleep(1000);
//     imgElement.src=prev_img_src;
// }

function onSelect(r, c) {
    var imagesList = document.getElementsByClassName('img_btn');
    var x = imagesList[2].disabled;
    var res = r.toString() + c.toString();
    var y = document.getElementById("prompt1");
    if (!x) {
        y.innerHTML="";
        if (gpwd_set.has(res)) {
            gpwd_set.delete(res);
            document.getElementById(res).style.opacity = 1;
        } 
        else
        {
            if(gpwd_set.size<3)
            {
                gpwd_set.add(res);
                document.getElementById(res).style.opacity = 0;
                // display_image_count(res,gpwd_set.size)
            }
            else
            {
                y.innerHTML="Select at max 3 images only!";
                y.style.color='red';
            }
        }
    }
}