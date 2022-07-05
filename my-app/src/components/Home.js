import React from "react";
import NaviBar from "./NaviBar";
import image from "../images/home.jpeg"
import styles from "../style/home_about.module.scss"


export default class Home extends React.Component {
    render() {
        return <>
            <NaviBar/>
            <div className={styles.display_elements}>
                <img className={styles.img} src={image} alt={'Home'}/>
                <h1 className={styles.text_header}>Welcoming to the home page</h1>
                <p className={styles.description}>The idea of what constitutes a text has evolved over time. In recent years, the dynamics of
                    technology—especially social media—have expanded the notion of the text to include symbols such as
                    emoticons and emojis. A sociologist studying teenage communication, for example, might refer to
                    texts that combine traditional language and graphic symbols. </p>
            </div>

        </>
    }
}
