import React, {PureComponent, Fragment} from 'react'
import { Input, Button } from '@material-ui/core';
import getLocalAsJson from './fetch'


export default class Home extends PureComponent {
    create = async () => {
        try {
            const response = await getLocalAsJson(
            `createCart?clientId=${sentence}`
            )
            return response.json()
        
            // router.navigate("/list", { substrings: json })
        } catch (err) {
            console.log('hubo un error', err)
        }
    }

    render() {
        return (
            <>
              <Input placeholder='User Id' key='user'/>
              <Input placeholder='Password' id='password' type='password'/>
              <Button onClick={this.create}>Crear Carrito</Button>
            </>
          );
    }
}