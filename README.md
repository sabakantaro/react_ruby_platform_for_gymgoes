# <a href="/">Gotore</a>

### 🚧[WIP]🚧
This app is using AWS, and it takes a lot of cost.</br>
Therefore I stop deploying this app now.</br>

And this is just for my skill proof.</br>
So I don't plan to use this app for business.</br>

<img width="1440" alt="Screenshot 2023-05-08 at 11 33 16" src="https://user-images.githubusercontent.com/79243411/236903322-af9a8bf4-6476-4d11-895e-5aa02144e40a.png">


## 【Summary】
Thank you for viewing this work.</br></br>
It is a muscle training social media platform app aimed at people who started muscle training to continue without frustration.</br>
With this application, which is a muscle training social media platform, you can find muscle training friends and exchange information with them, so you can make horizontal connections and make muscle training a habit without getting frustrated.</br></br>
I developed everything by myself, referring to official manuals and technical articles.</br>

### 【Programing language】

・Ruby(3.0.3)<br>
・Rails(6.1.4.4)<br>

・HTML/CSS<br>
・Javascript<br>
・React.js<br>

### 【Development env. & infrastructure】

・Docker/docker-compose<br>
・MySQL(8.0.23)<br>
・Github Actions<br>
・Puma<br>
・Nginx<br>
・AWS<br>
・Terraform<br>

### 【Test & Formatter】

・Rspec<br>
・Rubocop<br>
・ESlint<br>
・Prettier<br>

### Other points I noticed during development

- The point which was conscious of team development<br>
We used pull requests on github to subdivide the feature implementation. <br>
- Single Page Application<br>
I used React.js for frontend and Ruby on Rails for backend.<br>
And I separated them.<br>
It makes this app readable.<br>
- Automatic deployment<br>
Implemented automatic deployment using Github Actions. <br>

## Background

There are two reasons for the development of this work. <br>
The first is that in recent years, due to the influence of the coronavirus, there have been fewer opportunities to go out, and more people have started exercising, such as home training, to alleviate the lack of exercise. <br>
In recent years, the number of sports gyms has increased and it has become easier to start exercising, but it takes time to see visible results, and many people get frustrated along the way. In order to do so, we created an social media type application that allows you to easily connect while sharing information. <br>
Second, I wanted to make it easier for people with muscle training experience to find a training method that suits them. <br>
It's been 4 years since I started muscle training myself, and for the first 3 years, I continued muscle training with reference to videos on the Internet, but I continued training that didn't suit my body, and I didn't do well. I couldn't put on muscle. <br>
However, I learned nutrition and training knowledge by myself, listened to people who have experience in muscle training on  social media, and practiced it for a year. I wanted to make it easy to find the method, so I created his  social media dedicated to muscle training.

## Feature List/Details

### User functions

・ New registration, login, logout, edit user information<br>

### Post functions

・Post list, post, edit, delete function<br>
・Image posting function<br>
- Image preview display<br>
・Search function (fuzzy search is possible on the posting screen)<br>
・Comment function for posts<br>
・Reply function for comments<br>

### Follow function

・Follow and unfollow function<br>
・Follow and follower list display function<br>

### Favorite Feature

・A function that allows you to favorite posts<br>
・Favorite post count increases or decreases<br>
・Favorite post list display function (on My Page)<br>

### Message function

・You can create a one-on-one chat room<br>
・Message sending function<br>

### Notifications

・If there is a follow or message from another user, it will be displayed in the notification list<br>

### Other features

・Responsive support (implemented with MUI)<br>
・Mobile screen header menu bar<br>

## Infrastructure configuration

![AWS Networking (updated)](https://user-images.githubusercontent.com/79243411/236905931-eaa0c499-387c-4c8b-b199-1b41783a30b0.png)

## ER diagram

![Gotore_ER](https://user-images.githubusercontent.com/79243411/236906720-294d6f9a-deb5-42c7-b1e2-8f395e9ac2ad.png)

## Plans for future improvements

・Optimize search functionality with Elasticsearch<br>
・Introduce loading animations, etc., and improve UI/UX<br>

#### Thank you so much!
