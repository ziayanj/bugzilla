# This file contains all the record creation needed to seed the database with its default values.
# The data can be loaded with the rails db:seed command (or created alongside the database with db:setup).

User.create(type: 'Manager', name: 'main', email: 'main@main.com', password: 'random')
User.create(type: 'Manager', name: 'manager', email: 'manager@manager.com', password: 'random')
User.create(type: 'Developer', name: 'dev', email: 'dev@dev.com', password: 'random')
User.create(type: 'Developer', name: 'ali', email: 'ali@ali.com', password: 'random')
User.create(type: 'Developer', name: 'dev2', email: 'dev2@dev2.com', password: 'random')
User.create(type: 'Qa', name: 'qa', email: 'qa@qa.com', password: 'random')
User.create(type: 'Qa', name: 'Quality Assurance', email: 'qa2@qa2.com', password: 'random')

User.first.projects.create(title: 'First', description: 'This is a very short description of the project.')
User.first.projects.create(title: 'Project X', description: 'This is a very short description of the project.')
User.first.projects.create(title: 'Important Project', description: 'This is a very short description of the project.')
User.second.projects.create(title: 'Project Y', description: 'This description gives information about what the project.')
User.second.projects.create(title: 'Dummy Project', description: 'This description gives information about what the project.')

Bug.create(title: "Important", description: "This is an important bug", qa_id: Qa.first.id, project_id: Project.first.id, deadline: "2023-05-09 18:58:00", category: :bug, status: :created) 
Bug.create(title: "Another", description: "This is another bug", qa_id: Qa.first.id, project_id: Project.first.id, deadline: "2023-07-09 18:58:00", category: :bug, status: :created) 
Bug.create(title: "Weird bug", description: "This is a weird bug", qa_id: Qa.first.id, project_id: Project.first.id, deadline: "2023-05-09 18:58:00", category: :bug, status: :started) 
