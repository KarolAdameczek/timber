import { Component } from "react";
import { loginUser } from "./myactions";

export class LoginView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      email: "",
      password: ""
    };
  }

  render() {
    const onSubmit = (e) => {
      e.preventDefault();
      this.props.dispatch(loginUser(this.state.email, this.state.password));
    };

    return (
      <div>
        <h1>Logowanie</h1>
        <form className="form" onSubmit={onSubmit}>
          <ul>
            <li>
              <input
                placeholder="Email"
                onChange={(e) =>
                  this.setState({
                    email: e.target.value
                  })
                }
              ></input>
            </li>
            <li>
              <input
                type="password"
                placeholder="Hasło"
                onChange={(e) =>
                  this.setState({
                    password: e.target.value
                  })
                }
              ></input>
            </li>
            <li>
              <input type="submit" value="Zaloguj"></input>
            </li>
          </ul>
        </form>
      </div>
    );
  }
}
