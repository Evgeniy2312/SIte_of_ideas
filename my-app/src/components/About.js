import React from "react";
import NaviBar from "./NaviBar";
import styles from "../style/home_about.module.scss"
import image from "../images/about.jpg";


export default class About extends React.Component {
    render() {
        return <>
            <NaviBar/>
            <div className={styles.display_elements}>
                <img className={styles.img} src={image} alt={'About'}/>
                <h1 className={styles.text_header}>About</h1>
                <p className={styles.description}> Traditionally, a text is understood to be a piece of written or spoken material in its primary form
                    (as opposed to a paraphrase or summary). A text is any stretch of language that can be understood in
                    context. It may be as simple as 1-2 words (such as a stop sign) or as complex as a novel. Any
                    sequence of sentences that belong together can be considered a text. </p>
            </div>
        </>
    }
}