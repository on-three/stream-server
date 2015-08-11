var spawn = require('child_process').spawn;
var net = require('net');

if(process.argv.length<3) {
  console.error("USAGE: mpv-test <input video file or url>");
}
var vid = process.argv[2]

proc = spawn('mpv', [vid, '--input-unix-socket=/tmp/mpvsocket'], { stdio: 'inherit' });

//var call = 'mpv https://www.youtube.com/watch?v=iN6Rlh4KonQ --input-unix-socket=/tmp/mpvsocket'

proc.on('exit', function (code) {
   console.log('Child process exited with exit code ' + code);
});

function try_connect() {
  var client = net.connect({path: '/tmp/mpvsocket'}, function() {
  console.log('Connected');
  client.write('{ "command": ["get_property", "playback-time"] }\n');
  });
  client.on('data', function(data) {
  console.log('Received: ' + data);
  client.destroy(); // kill client after server's response
});

client.on('error', function(error) {
    console.log("ERROR: ", error)
      //retry
      //client = try_connect();
})
setTimeout(try_connect, 5000);
return client;
}

setTimeout(try_connect, 1000);
