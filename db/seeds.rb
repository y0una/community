Anna = User.create(first_name:"Anna", last_name:"An", email:"a@a.com", user_name:"annabanana")
Brian = User.create(first_name:"Brian", last_name:"Baker", email:"b@b.com",user_name:"bookwormb")
Catherine = User.create(first_name:"Catherine", last_name:"Clark", email:"c@c.com", user_name:"cyclingcathy")

relationships = Chat.create(interest:"relationships")
fitness_nutrition = Chat.create(interest:"fitness & nutrition")
creative = Chat.create(interest:"creative")
spiritual = Chat.create(interest:"spiritual")
technical = Chat.create(interest:"technical")
