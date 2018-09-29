import React, { Component } from 'react';
import './App.css';

class App extends Component {
  render() {
    return (
      <div>
        <header className="header container">
          <h1 className="brand">Photog</h1>
          <nav>
            <ul callName="nav-list">
              <li>Albums</li>
              <li>Folders</li>
              <li>Persons</li>
              <li>Favorites</li>
            </ul>
          </nav>
        </header>
        <p className="App-intro">
          To get started, edit <code>src/App.js</code> and save to reload.
        </p>
      </div>
    );
  }
}

export default App;
