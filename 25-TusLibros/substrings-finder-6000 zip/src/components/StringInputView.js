class StringInputComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      clientId: '',
      password: '',
      error: false
    }
  }

  handleUserChange(event) {
    this.setState({
      clientId: event.target.value
    })
  };

  handlePasswordChange(event) {
    this.setState({
      password: event.target.value
    })
  };

  componentWillUnmount() {
    this.timeout && clearTimeout(this.timeout)
  }

  handleSend() {
    const {
      router,
    } = this.props

    const {
      clientId,
      password
    } = this.state

    getLocalAsJson(`createCart?clientId=${clientId}&password=${password}`)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        router.navigate("/catalog", { cartId: json, user: clientId })
      })
      .catch(() => {
        this.setState({
          error: true,
          clientId: '',
          password: ''
        })
        this.timeout = setTimeout(() => {
          this.setState({
            error: false
          })
          this.timeout = null
        }, 3000);
      });
  }

  render() {
    const {
      clientId,
      password
    } = this.state

    const {
      classes,
    } = this.props

    return (
      <div>
        <Typography component="h1" gutterBottom>
          Ingrese un usuario y contraseña
          </Typography>
        <FormControl fullWidth className={classes.textField}>
          <TextField
            id="outlined-adornment-amount"
            value={clientId}
            onChange={(ev)=>this.handleUserChange(ev)}
            placeholder={'User Id'}
          />
          <TextField
            id="outlined-adornment-amount"
            value={password}
            onChange={(ev)=>this.handlePasswordChange(ev)}
            type='password'
            placeholder={'Password'}
          />
        </FormControl>

        <Button
          color="inherit"
          onClick={(ev)=>this.handleSend(ev)}>
          Create Cart
      </Button>
      {this.state.error && <div className={classes.error}>Usuario o contraseña invalidos</div>}
      </div>
    )
  }
}

// Add style
const StringInputView = withStyles(styles, {
  withTheme: true
})(StringInputComponent)
