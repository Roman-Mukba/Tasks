//1.Select all universities. Show name and accreditation
db.universities.find(
{},
{name: 1, accreditation: 1, _id: 0}
);

//2.Select university without coordinates. Show only Address information
db.universities.find(
{"address.coordinates" : {$exists: false}}, 
{ address:1},  
{_id:0}
)

//3.Select university with State = “MA” and zipcode not equal to “27897”. Show id, name, state, zipcode
db.universities.find(
{"address.state": "MA", "address.zipcode": { $ne: ["27897"] } },
{ id:1, name:1, "address.state":1, "address.zipcode":1 } 
)
 
//4.Select users with Date of Birth more than (>) 1980 year and less than current date. Show only Date of Birth
db.users.find(
{ DateOfBirth: {$gte:ISODate("1980-01-01T00:00:00.000Z"), $lt:new Date()} },
{ DateOfBirth:1, _id:0 }
)

//5.Change course name and delete all other information (university_id, users) for course, which contains only students
db.courses.update(
{'users.role' : {$nin : ["instructor"]}},
{$set : { 'name' : 'NewCourse1'}},
{multi : true}
)
db.courses.update(
{name:"NewCourse1"},
{$unset:{"iniversities_id":1,"users":1}}
)

//6.Select courses with max number of users. Show course name, user roles, amount of users
db.courses.find().sort({users:-1}).limit(1)

//7.Select user with the longest MiddleName. Show _id, MiddleName, length
db.users.aggregate(
    [{$project:{"MiddleName":1,
    "lenght": {$strLenCP: "$MiddleName" }}},
    {$match: {MiddleName: {$exists:true}}},
    {$sort: {"lenght":-1}},
    {$limit:1}])
   
//8.Update only the course name, which contains every user role
db.courses.updateMany(
{$and :[{ "users.role": "instructor"},
{"users.role": "admin"},{"users.role": "student"}]},
{$set: {"name" : "NewCourse2"}}, {multi:true}
)
//9.Replace User document with Name = “Pavel” (insert your values and pay attention for the new structure. Use .find() before replacement and compare values after)
db.users.find(
{FirstName: "Pavel"},
{}
);

db.users.replaceOne(
{"FirstName": "Pavel"},
{"FirstName": "ViktorPavlik"},
{upsert: true}
);
    
db.users.find(
{FirstName: "ViktorPavlik"}
);

//10.Delete user which has only LastName by 2 ways (use delete()and remove() commands)(i.e. MiddleName, Date of Birth, First Name are null).
db.users.deleteOne(
{"FirstName": {"$in": [null], $exists: false}}, 
{"MiddleName": {"$in" : [null], $exists: false}}, 
{"DateOfBirth": {"$in" : [null], $exists: false}}, 
{"LastName": {"$in" : [null], $exists: true}}
);













