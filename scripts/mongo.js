// This creates the database, if it doesn't already exist
// TBH, this is probably unnecessary, but it serves as an init/migration script

if(db.getMongo().getDBNames().indexOf('screencastify') === -1){
    db.createCollection('init')
}