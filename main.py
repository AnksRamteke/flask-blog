from flask import Flask, render_template,request , session , redirect
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import json
from flask_mail import Mail
import os
import math
from werkzeug import secure_filename



with open('config.json' ,'r') as c:
    params = json.load(c)["params"]

local_server = True
app = Flask(__name__)
app.secret_key = 'super-secrete-key'
app.config['UPLOAD_FOLDER'] = params ['upload_location'] 

app.config.update(
     MAIL_SERVER = "smtp.gmail.com",
     MAIL_PORT = "465",
     MAIL_USE_SSL =True,
     MAIL_USERNAME ="params['gmail-user']",
     MAIL_PASSWORD = "params['gmail-password']"


)
mail = Mail(app)

if local_server():
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod uri']

db = SQLAlchemy(app)


class Contact(db.Model):
    Sr_No = db.Column(db.Integer, primary_key=True)
    Name = db.Column(db.String(80),  nullable=False)
    Email = db.Column(db.String(20), nullable=False)
    Phone_No= db.Column(db.String(12), nullable=False)
    mess = db.Column(db.String(120), nullable=False)
    Date = db.Column(db.String(12), nullable=False)
    img_file = db.Column(db.String(12), nullable=False)

class Posts(db.Model):
    Sr_No = db.Column(db.Integer, primary_key=True)
    tItle = db.Column(db.String(80),  nullable=False)
    slug = db.Column(db.String(21), nullable=False)
    tagline= db.Column(db.String(120), nullable=False)
    contact_No= db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=False)



@app.route('/')
def home():
    Posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts)/int(params['no_of_posts']))
    #[0 :params['no_of_posts']]
    Page =numbers.args.get('Page')
    if(not str(Page).isnumeric()):
        Page = 1
    Page = int(Page)
    Posts = Posts[(Page -1)*int(params['no_of_posts']): (Page -1)*int(params['no_of_posts']) + int(params['no_of_posts']) ]
    #pagination Logic
    #First
    if (Page == 1):
        prev = '#'
        next = '/?Page = ' + str(page+1)

    elif(Page == last):
        prev = '/?Page = ' + str(page-1)
        next= '#'
    else:
        prev = '/?Page = ' + str(page-1)
        next = '/?Page = ' + str(page+1)

    return render_template("index.html", params = params, posts = posts, prev = prev , next = next )

@app.route('/about')
def about():
    return render_template("about.html" , params = params)

@app.route('/dashboard' methods = ['GET','POST'])
def dashboard():
    if ('user' in session and session['user'] == params['admin_user']):
         Posts = Posts.query.all()
         return render_template('dashboard.html' , params = params , posts = Posts)

    if request.method == 'POST':
        username = request.form.get('uname')
        userpass = request.form.get('pass')
        if (username == params['admin_user'] and userpass == params['admin_password']):
            #set the session variable
            session ['user'] = username
            Posts = Posts.query.all()
            return render_template('dashboard.html', params = params)

    return render_template("login.html" , params = params ,posts = Posts)


@app.route('/post/<string:post_slug>',method = ['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug = post_slug).first()

    return render_template("post.html" , params = params, post = Posts )



@app.route('/edit/<string:SrNo>', method = ['GET' 'POST'])

def edit(SrNo):
    if ('user' in session and session['user'] == params['admin_user']):
        if request.method == 'POST':
            box_title = request.form.get('title') 
            tline = request.form.get('tline') 
            slug = request.form.get('slug') 
            content =  request.form.get('content') 
            img_file = request.form.get('img_file')
            date = datetime.now()

            if SrNo == "0":
                post = Posts(title = box_title ,slug = slug ,Content = content , tagline = tline , img_file = img_file , date = date)
                db.session.add(post)
                db.session.commit 
            else:
                post = Posts.query.filter_by(SrNo = SrNo).first()
                post.title = box_title
                post.slug = slug
                post.Content = content
                post.tagline = tline
                post.img_file = img_file
                post.date = date
                db.session.commit 
                return redirect ('/edit/' + SrNo)

        post = Posts.query.filter_by(SrNo = SrNo).first()
        return render_template('edit.html', params = params ,post = post )


@app.route('/uploader', method = ['GET' 'POST'])
def uploader():
    if ('user' in session and session['user'] == params['admin_user']):
        if (request.method == 'POST'):
            f = request.file = ['file1']
            f.save(os.path.join)(app.config['UPLOAD_FOLDER'] , secure_filename(f.filename))
            return "uploaded successfully"
    



@app.route('/logout')
def logout():
    session.pop.('user')
    return redirect('/dashboard')

@app.route('/delete/<string:SrNo>', method = ['GET' 'POST'])
def delete():
    if ('user' in session and session['user'] == params['admin_user']):
        post = Posts.query.filter_by(SrNo = SrNo).first()
        db.session.delete('post')
        db.session.commit()
    return redirect('/dashboard')



@app.route('/contact', method = ['GET' 'POST'])
def contact():
    if (request.method == 'POST'):
        name  = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        entry = Contacts(Name = name,phone_No = phone, mess = message, Email = email, date = datetime.now())
        db.session.add(entry)
        db.session.commit()
        mail.send_message = ('New message from' + name, 
                             sender = 'email' , 
                            recipients = [params['gmail-user']],
                            body = message + "\n" + phone 
                            )

    return render_template('/contact.html')

app.run(debug=True) 