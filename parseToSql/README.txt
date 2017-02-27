Setup a MySQL db (this was built against Server version: 5.7.17)
You'll need node setup on your machine. I haven't built many node projects...that may be all you need.

download any of the source .csv's that you want to load int the db from: https://s3.amazonaws.com/hubway-data/index.html
Then run `node tripParser.js`

target will be popualted with a file called trips.sql

you can import it with mysql -uroot -p hubway < ./target/trips.sql

where hubway is the name of the database you created

Note also, this script doesn't clean the table ahead of it so running it twice will duplicate that data.
