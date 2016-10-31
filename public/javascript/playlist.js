var audio;
var playlist;
var tracks;
var current;

init();
function init(){
    current = 0;
    audio = $('audio');
    playlist = $('#up_next');
    tracks = playlist.find('li a');
    len = tracks.length - 1;
    audio[0].volume = .5;
    audio[0].play();
    playlist.find('a').click(function(e){
        e.preventDefault();
        link = $(this);
        current = link.parent().index();
        run(link, audio[0]);
    });
    audio[0].addEventListener('ended',function(e){
        current++;
        if(current == len){
            current = 0;
            link = playlist.find('a')[0];
        }else{
            link = playlist.find('a')[current];
        }
        run($(link),audio[0]);
    });
}
function run(link, player){
        player.src = link.attr('href');
        par = link.parent();
        par.addClass('active').siblings().removeClass('active');
        audio[0].load();
        audio[0].play();
}

// ===========================================
          // add new js  \\
// ===========================================
var objectUrl;

$("#audio").on("canplaythrough", function(e){
    var seconds = e.currentTarget.duration;
    var duration = moment.duration(seconds, "seconds");

    var time = "";
    var hours = duration.hours();
    if (hours > 0) { time = hours + ":" ; }

    time = time + duration.minutes() + ":" + duration.seconds();
    $("#duration").text(time);

    URL.revokeObjectURL(objectUrl);
});

$("#file").change(function(e){
    var file = e.currentTarget.files[0];

    $("#filename").text(file.name);
    $("#filetype").text(file.type);
    $("#filesize").text(file.size);

    objectUrl = URL.createObjectURL(file);
    $("#audio").prop("src", objectUrl);
});
