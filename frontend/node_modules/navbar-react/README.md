# navbar-react


[![NPM](https://img.shields.io/npm/v/navbar-react.svg)](https://www.npmjs.com/package/navbar-react) [![JavaScript Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://standardjs.com)

## Install

```bash
npm install --save navbar-react
```

## Usage

```jsx
import React, { Component } from 'react'

import Navbar from 'navbar-react'

class Example extends Component {
  render () {
    return (
      <Navbar />
    )
  }
}
```
## Mandatory Props

|  Props         |     Type       | 
| -------------  |:------------- |
| items          | Array of Object  <b>{name: "Item 1", href: "#" }</b>       |
| color          | string      |
| logo           | image string 

## Utility Props

| Props          |     Type       | 
| -------------  |:------------- |
| itemTextColor  |color name
| titleColor     |color name
| hoverColor     |color name
| title          |string


## Support this project
- Star GitHub repository :star:
- Create pull requests, submit bugs or suggest new features
- Follow updates on [Github](https://github.com/SdSalaat)


## License

MIT © [SdSalaat](https://github.com/SdSalaat)
