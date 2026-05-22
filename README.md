# Tic Tac Toe Web Application

A web-based Tic Tac Toe game built using Java Servlets, JSP, HTML, CSS, and MVC architecture. This application allows users to register,
log in, and play the Tic Tac Toe game through a browser.

## Features
- User Registration
- User Login / Logout
- Guest Game Mode
- Restart Game Option
- Interactive Tic Tac Toe gameplay
- Session management
- JSP-based frontend
- Servlet-based backend using MVC architecture

## Technologies Used
### Backend
- Java
- Java Servlets
- JSP (Java Server Pages)

### Frontend
- HTML
- CSS
- JavaScript

### Server
- Apache Tomcat

### IDE
- Eclipse IDE

## Project Structure

TicTacToeServlet/
│── src/main/java/com/example/tictactoe/
│ ├── controller/
│ │ ├── GameServlet.java
│ │ ├── GuestGameServlet.java
│ │ ├── LoginServlet.java
│ │ ├── LogoutServlet.java
│ │ ├── RegisterServlet.java
│ │ ├── RestartServlet.java
│ │ └── SignupServlet.java
│
│── src/main/webapp/
│ ├── META-INF/
│ ├── afterLogin.jsp
│ ├── game.jsp
│ ├── home.jsp
│ ├── index.jsp
│ ├── login.jsp
│ ├── playerNames.jsp
│ └── signup.jsp
│
│── .classpath
│── .project
│── .gitignore

## How to Run
1. Clone the repository:
```bash
git clone https://github.com/your-username/TicTacToeServlet.git
Import project into Eclipse IDE
Configure Apache Tomcat server
Add project to Tomcat server
Run the application
Open browser:
http://localhost:8080/TicTacToeServlet/
Pages
Home Page
Login Page
Signup Page
Game Page
Guest Mode Page
Future Improvements
Multiplayer support
Database integration
Score tracking
Better UI design
AI opponent mode
Author

Gagan Prajapati
