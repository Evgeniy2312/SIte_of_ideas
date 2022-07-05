import React from "react";
import {Button, Container, Dropdown, DropdownButton, Nav, Navbar} from "react-bootstrap";
import {Link, useNavigate} from "react-router-dom";
import axios from "axios";
import styles from "../style/navibar.module.scss";
import {getToken} from "../jwt_functions"

export default function NaviBar() {

    const history = useNavigate();


    const logOut = async (e) => {
        e.preventDefault();
        axios.delete("http://localhost:3001/logout", {
            headers: {
                "Content-Type": "application/json",
                "Authorization": getToken(),
            },
        }).then((res) => {
            localStorage.removeItem("token")
            localStorage.removeItem("currentUser")
            localStorage.removeItem("lastLoginTime")
            console.log("Logout")
            history('/login')

        }).catch((err) => {
                alert(err);
                history("/login")
            }
        );
    }

    function isObj(object) {
        let flag = false;
        for (let key in object) {
            flag = object.hasOwnProperty(key);
        }
        return flag;
    }

    function getElements() {
        let elements;
        let currentUser = JSON.parse(localStorage.getItem("currentUser"));
        if (!isObj(currentUser)) {
            elements =
                <>
                    <Link to="/registration" style={{marginRight: "15px"}}><Button
                        variant={"primary"}>Registration</Button></Link>
                    <Link to="/login"><Button variant={"primary"}>LogIn</Button></Link>;
                </>
        } else {
            elements =
                <>
                    <p className={styles.name}>{currentUser.name}</p>
                    <DropdownButton id="dropdown-basic-button" title="Dropdown button">
                        <Dropdown.Item href="#">Account</Dropdown.Item>
                        <Dropdown.Item href="/my_ideas">Ideas</Dropdown.Item>
                        <Dropdown.Divider />
                        <Dropdown.Item href="#" onClick={logOut}>LogOut</Dropdown.Item>
                    </DropdownButton>

                </>
        }
        return elements;
    }

    return (
        <>
            <Navbar bg="dark" variant="dark">
                <Container>
                    <Navbar.Brand href="#home">Navbar</Navbar.Brand>
                    <Nav className="me-auto">
                        <Nav.Link><Link to="/home">Home</Link></Nav.Link>
                        <Nav.Link><Link to="/about">About</Link></Nav.Link>
                    </Nav>
                    {getElements()}
                </Container>
            </Navbar>
        </>
    )
}