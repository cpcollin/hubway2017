const csv = require('csv-streamify')
const fs = require('fs')

var folderName = './data/';
var filesToParse = [];
var fileIndex = 0;

var linesWritten = 0;
var comma = '';


function parseTripFormatAIntoSql(data) {
  var tripString = "(";
  tripString += '"' + data['Duration'] + '",';  
  tripString += 'STR_TO_DATE("' + data['Start date'] + '", "%m/%d/%Y %k:%i"),';
  tripString += 'STR_TO_DATE("' + data['End date'] + '", "%m/%d/%Y %k:%i"),';
  tripString += '"' + data['Start station number'] + '",';
  tripString += '"' + data['End station number'] + '",';
  tripString += '"' + data['Bike number'] + '",';
  tripString += '"' + data['Member type'] + '",';
  tripString += 'null,';
  tripString += '"' + data['Zip code'] + '",';
  tripString += '"' + data['Gender'] + '"';
  tripString += ')';
  
  return tripString;
}

function parseTripFormatBIntoSql(data) {
  if (data['tripduration'] == undefined || data['starttime'] == undefined || data['starttime'] == 'undefined' || data['stoptime'] == undefined || data['stoptime'] == 'undefined') {
    console.log("failing parseTripFromBIntoSql:", data);
    console.log("startime:", data['starttime'], data.starttime);
 
    throw "Welp fuck.";
  }

  var tripString = "(";
  tripString += '"' + data['tripduration'] + '",';  
  tripString += 'STR_TO_DATE("' + data['starttime'] + '", "%Y-%m-%d %H:%i:%s"),'; // "%m/%d/%Y %k:%i"),';
  tripString += 'STR_TO_DATE("' + data['stoptime'] + '", "%Y-%m-%d %H:%i:%s"),'; // "%m/%d/%Y %k:%i"),';
  // tripString += '"' + data['starttime'] + '",';
  // tripString += '"' + data['stoptime'] + '",';
  tripString += '"' + data['start station id'] + '",';
  tripString += '"' + data['end station id'] + '",';
  tripString += '"' + data['bikeid'] + '",';
  tripString += '"' + data['usertype'] + '",';
  tripString += '"' + data['birth year'] + '",';
  tripString += 'null,';
  tripString += '"' + data['gender'] + '"';
  tripString += ')';
  
  return tripString;
}

var writeStream = fs.createWriteStream(`./target/trips.sql`);

var options = {
  objectMode: true,
  newline: '\r\n',
  columns: true,
  inputEncoding: 'utf8'
};

function processLine(line) {
  if (linesWritten == 0 || linesWritten % 1000 == 0) {
    comma = '';
    writeStream.write(`; INSERT INTO trips (duration, start_date, end_date, start_station_number, 
                       end_station_number, bike_id, member_type, birth_year, zip_code, gender) VALUES`);
  }

  var tripString = null;
  if (line['Duration'] != null) {
    tripString = parseTripFormatAIntoSql(line);
  } else {
    tripString = parseTripFormatBIntoSql(line);
  }

  writeStream.write(comma + '\n' + tripString);
  comma = ',';

  linesWritten++;
}

function reRunParser() {
  console.log("Re-running parser [" + fileIndex + "]:", filesToParse[fileIndex]);
  // writeStream.write(';');

  if (fileIndex == filesToParse.length - 1) {
    return;
  }

  fileIndex++;
  console.log("re-creating read stream:", filesToParse[fileIndex]);
  fs.createReadStream(folderName + filesToParse[fileIndex]).pipe(csv(options).on('data', processLine).on('end', reRunParser));
}

fs.readdir(folderName, (err, files) => {
  files.forEach(file => {
    console.log("Found file:", file);
 
    if (file.endsWith('csv')) {
      filesToParse.push(file);
      console.log(file);
    } 
  });

  console.log("creating read stream:", filesToParse[fileIndex]);
  fs.createReadStream(folderName + filesToParse[fileIndex]).pipe(csv(options).on('data', processLine).on('end', reRunParser));
});
