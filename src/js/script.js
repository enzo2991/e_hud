$(document).ready(function(){
    window.addEventListener("message",function(event){
        if(event.data.basicneed){
            setProgress('.progressbar-health',event.data.health)
            setProgress('.progressbar-armor',event.data.armor)
            setProgress('.progressbar-thirst',event.data.thirst)
            setProgress('.progressbar-hunger',event.data.hunger)
        } else if(event.data.voice){
            var element = '.progressbar-voice';
            switch(event.data.number){
                case 1: 
                    setProgress(element,25);
                    break;
                case 2: 
                    setProgress(element,50);
                    break;
                case 3: 
                    setProgress(element,75);
                    break;
                case 4: 
                    setProgress(element,100);
                    break;
                default : 
                    setProgress(element,50);
            }
        } else if (event.data.toggleUI) {
            if(event.data.value) {
                $(".hud").hide()
            } else {
                $(".hud").show()
            }
        } else if (event.data.voiceEnabled) {
            if(event.data.value) {
                $(".progressbar-voice").css("background-color","#BFDEBB")
            } else {
                $(".progressbar-voice").css("background-color","#BBC8DE")
            }
        } else if (event.data.timeEnabled){
            if(event.data.value == 0){
                $("#service").hide()
            } else {
                $("#service").show()
                $(".servicetime").text(event.data.value)
            }
        }
    })

    function setProgress(element,number){
        $(element).width(number);
        if(element != '.progressbar-voice'){
            if(number <= 25){
                $(element).css('background-color', 'red');
            } else if(number <= 50){
                $(element).css('background-color', 'orange');
            } else {
                $(element).css('background-color', '#BBC8DE')
            }
        }
    }

    setInterval(function(){
        var now = new Date(),time = (now.getHours()<10?'0':'') + now.getHours() + ':' + (now.getMinutes()<10?'0':'') + now.getMinutes();
        document.getElementById("hour").innerHTML = [time];
        console.log()
    },1000)

})