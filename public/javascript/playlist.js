var audio;
var playlist;
var tracks;
var current;

init();
function init(){
    current = 0;
    audio = $('audio');
    playlist = $('.play_song');
    tracks = playlist.find('a');
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


// ON START
$('.showing_mp3').hide();
$('.showing_embed').hide();
$('.showing_video').hide();
$('.show_media').hide();


// DISPLAY collection
$('#show_mp3').change(function () {
  if($(this).is(":checked")) {
    $('.showing_mp3').show();
    return;
    }
  $('.showing_mp3').hide();
});

$('#show_embed').change(function () {
  if($(this).is(":checked")) {
    $('.showing_embed').show();
    return;
    }
  $('.showing_embed').hide();
});

$('#show_video').change(function () {
  if($(this).is(":checked")) {
    $('.showing_video').show();
    return;
    }
  $('.showing_video').hide();
});







// handle toggles for media embed and video types to display embed media:
$( ".toggle_media" ).click(function(e) {
  e.preventDefault();
  ($(e.target).closest('.showing_embed').find('.show_media').toggle(200))
});

$( ".toggle_media" ).click(function(e) {
  console.log($( ".toggle_media" ));
  e.preventDefault();
  ($(e.target).closest('.showing_video').find('.show_media').toggle(200))
});
