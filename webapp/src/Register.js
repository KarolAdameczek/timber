import { Component } from "react";
import { registerUser } from "./myactions";

export class RegisterView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      name: "",
      email: "",
      email2: "",
      password: "",
      password2: ""
    };
  }

  render() {
    const onSubmit = (e) => {
      e.preventDefault();
      this.props.dispatch(
        registerUser(
          this.state.name,
          this.state.email,
          this.state.email2,
          this.state.password,
          this.state.password2
        )
      );
    };

    return (
      <div>
        <h1>Rejestracja</h1>
        <form className="form" onSubmit={onSubmit}>
          <ul>
            <li>
              <input
                placeholder="Imię"
                onChange={(e) =>
                  this.setState({
                    name: e.target.value
                  })
                }
              ></input>
            </li>
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
                placeholder="Powtórz email"
                onChange={(e) =>
                  this.setState({
                    email2: e.target.value
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
              <input
                type="password"
                placeholder="Powtórz hasło"
                onChange={(e) =>
                  this.setState({
                    password2: e.target.value
                  })
                }
              ></input>
            </li>
            <li>
              <input type="submit" value="Zarejestruj"></input>
            </li>
          </ul>
        </form>
      </div>
    );
  }
}