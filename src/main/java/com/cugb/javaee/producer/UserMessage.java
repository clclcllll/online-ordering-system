package com.cugb.javaee.producer;

public class UserMessage {
    private int userID;
    private String username;
    private String message;

    public UserMessage(int userID, String username, String message) {
        this.userID = userID;
        this.username = username;
        this.message = message;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @Override
    public String toString() {
        return "UserMessage{" +
                "userID=" + userID +
                ", username='" + username + '\'' +
                ", message='" + message + '\'' +
                '}';
    }
}
