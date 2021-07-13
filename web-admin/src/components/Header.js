import React from "react";
import { useHistory } from "react-router-dom";

export default function Header(props) {
	const history = useHistory();
	const username = localStorage.getItem('username');
	const signOut = () => {
		localStorage.setItem('username', '');
		history.goBack();
	}
	return (
		<header className="header-desktop" style={props.zIndex ? {zIndex: props.zIndex} : {}}>
			<div className="section__content section__content--p30">
				<div className="container-fluid">
					<div className="header-wrap">
						<form className="form-header" action="" method="POST">
							<input className="au-input au-input--xl" type="text" name="search" placeholder="Search for datas &amp; reports..." />
							<button className="au-btn--submit" type="submit">
								<i className="zmdi zmdi-search"></i>
							</button>
						</form>
						<div className="header-button">
							<div className="account-wrap m-r-20">
								<div className="account-item clearfix">
									<div className="image">
										<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/1024px-User-avatar.svg.png"
											alt={username}
										/>
									</div>
									<div className="content">
										<a className="js-acc-btn" href="#">{username}</a>
									</div>
								</div>
							</div>
							<div className="noti-wrap">
								<i className="fas fa-sign-out-alt" onClick={signOut}></i>
							</div>
						</div>
					</div>
				</div>
			</div>
		</header>
	);
}