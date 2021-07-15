import React, { useState } from 'react';
import { useHistory } from "react-router-dom";
import StaffService from '../services/StaffService';

export default function Login({ navigation }) {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [msg, setMsg] = useState('');
  const history = useHistory();
  const signIn = () => {
    const staffService = new StaffService();
    staffService.get(username, password).then(({ status, data }) => {
      console.log(data)
      if (status === 200) {
        localStorage.setItem('username', data.name);
        localStorage.setItem('authToken', data.authToken);
        history.push('/auth');
      } else {
        setMsg('Email or password is incorrect!')
      }
    })
    return false;
  }
  return (
    <div className="login-wrap">
        <div className="login-content">
            <div className="login-logo">
                <h1>Fero Admin</h1>
            </div>
            <div className="login-form">
                <form action="" method="post">
                    <div className="form-group">
                        <label>Email Address</label>
                        <input className="au-input au-input--full"
                            type="email" name="email" placeholder="Email"
                            onChange={ e => setUsername(e.target.value) }
                        />
                    </div>
                    <div className="form-group">
                        <label>Password</label>
                        <input className="au-input au-input--full"
                            type="password" name="password" placeholder="Password"
                            onChange={ e => setPassword(e.target.value) }
                        />
                    </div>
                    <div className="login-checkbox">
                        <label>
                            <input type="checkbox" name="remember" />Remember Me
                        </label>
                        <label>
                            <a>Forgotten Password?</a>
                        </label>
                    </div>
                    <button className="au-btn au-btn--block au-btn--blue m-t-20 m-b-20" type="button" onClick={ signIn }>sign in</button>
                </form>
                {
                  msg
                  ? <div className="alert alert-danger" role="alert">{ msg }</div>
                  : <div></div>
                }
                
            </div>
        </div>
    </div>
  );
}