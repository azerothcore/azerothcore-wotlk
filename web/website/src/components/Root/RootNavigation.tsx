import React from 'react';
import './Root.css';
import { Link, useRouteMatch } from 'react-router-dom';
import { classNames } from 'util/classNames';


interface NavLinkProps {
    url: string;
}

const NavLink: React.SFC<NavLinkProps> = ({ url, children }) => {
    const isMatched = Boolean(useRouteMatch(url));
    return (
        <Link to={url} className={classNames(isMatched && 'selected')}>{children}{isMatched && '*'}</Link>
    )
}


export function RootNavigation() {
    return (
        <nav className="Root-navigation">
            <h1>
                <span
                    style={{
                        textDecoration:'underline',
                        display:'inline-block',
                        width: 50,
                        height: 60,
                        border: '2px solid'
                    }}
                >A</span>
                renaCraft<span style={{color: 'rgba(255, 255, 255, 0.7)', display:'inline-block'}}>Project</span>
            </h1>
            <ul>
                {/* <li>
                    <NavLink url='/home'>Home</NavLink>
                </li>
                <li>
                    <span className="seperator">/</span>
                </li>
                <li>
                    <NavLink url='/about'>About</NavLink>
                </li>
                <li>
                    <span className="seperator">/</span>
                </li> */}
                <li>
                    <NavLink url='/create-account'>Create Account</NavLink>
                </li>
                {/* <li>
                    <span className="seperator">/</span>
                </li>
                <li>
                    <a rel="noopener noreferrer" href="https://discord.gg/dTSkUgU" target="_blank">Discord🡕</a>
                </li> */}
                <li>
                    <span className="seperator">/</span>
                </li>
                <li>
                    <a rel="noopener noreferrer" href="https://github.com/arenacraftwow/azerothcore-wotlk" target="_blank">Source Code↗</a>
                </li>
            </ul>
        </nav>
    )
}