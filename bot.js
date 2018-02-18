// reference: Twitter Bot Tutorial by Daniel Shiffman

var cron = require('node-cron');
console.log('cron is starting');
cron.schedule('0 0 0,3,6,9,12,15,18,21 * * *', () => {//second, minute, hour, day, month, weekday

  console.log('The p5 bot is starting');

  var Twit = require('twit');
  var config = require('./config');
  var T = new Twit(config);
  var exec = require('child_process').exec;
  var fs = require('fs');

  fs.readdir('./p5', readFiles);

  function readFiles(err, pnames) {
    for (var i = 0; i < pnames.length; i++) {
      if (pnames[i].indexOf('.') >= 0) {
        pnames.splice(i, 1);
      }
    }

    tweetIt();

    function tweetIt() {
      var os = require('os');
      var platform = os.platform();
      var pname = pnames[Math.floor(Math.random() * pnames.length)];
      // var pname = pnames[2]; // for test
      var cmd;
      if (platform == 'darwin') {
        cmd = 'processing-java --sketch=`pwd`/p5/' + pname + ' --run'; // on local
      } else {
        cmd = 'p5/' + pname + '/' + pname; // on aws
      }

      exec(cmd, processing);

      function processing() {
        var filename = 'p5/' + pname + '/output.png';
        var params = {
          encoding: 'base64'
        }
        var b64 = fs.readFileSync(filename, params);
        T.post('media/upload', {media_data: b64 }, uploaded);

        function uploaded(err, data, response) {
          var num;
          var id = data.media_id_string;
          fs.readFile('number.txt', { encoding: 'utf-8' }, function(err, data) {
            num = parseInt(data);
            num += 1;
            fs.writeFile('number.txt', num, function(err, data){});
            var tweet = {
              status: 'No.' + num + ': "' + pname + '"',
              media_ids: [id]
            }
            T.post('statuses/update', tweet, tweeted);
          });
        }

        function tweeted(err, data, response) {
          if (err) console.log("Something went wrong!");
          else console.log("It worked!");
          fs.unlink(filename, function (err) {
            if(err) console.log("File unlink error!");
          });
        }
      }
    }
  }

});
