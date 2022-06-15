import './App.css';
import {Link} from "react-router-dom";


function App() {
    return (
        <div style={{display: "flex", flexDirection: "column", alignItems: "center"}}>
            <h1 style={{color: "red"}}>App</h1>
            <nav>
                <Link to="/registration">Registration</Link> |{" "}
                <Link to="/login">LogIn</Link>
            </nav>
        </div>
    );
}

export default App;

