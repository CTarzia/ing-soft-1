class SubstringDetailsComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      quantity: props.quantity
    }
  }


  add = () => {
    getLocalAsJson(`addToCart?cartId=${this.props.cartId}&bookIsbn=${this.props.item.isbn}&bookQuantity=1`)
      .then(() => {
        this.setState({
          quantity: this.state.quantity + 1,
        })
      })
      .catch(err => {
        this.setState({
          error: err,
        })
      })

  }

  remove = () => {
    getLocalAsJson(`removeFromCart?cartId=${this.props.cartId}&bookIsbn=${this.props.item.isbn}`)
      .then(() => {
        this.setState({
          quantity: this.state.quantity - 1,
        })
      })
      .catch(err => {
        this.setState({
          error: err,
        })
      })

  }

  render() {
    const {
      // router,
      classes,
      item
    } = this.props

    const {
      details,
      loading,
      error,
    } = this.state

    if (loading) return <div>Loading...</div>
    if (error) return <div>{error}</div>
    return (
      <div>
        <Typography variant="h4" component="h4" gutterBottom>
          Detalles de <b>{item.title}</b>
        </Typography>

        <TextField
          id="outlined-read-only-input"
          label="Autor"
          defaultValue={item.author}
          className={classes.textFieldDetails}
          margin="normal"
          InputProps={{
            readOnly: true,
          }}
          variant="outlined"
        />
        <TextField
          id="outlined-read-only-input"
          label="ISBN"
          defaultValue={item.isbn}
          className={classes.textFieldDetails}
          margin="normal"
          InputProps={{
            readOnly: true,
          }}
          variant="outlined"
        />
        <IconButton
          //onClick={this.remove}
        >
          -
        </IconButton>
        <IconButton disabled>{this.state.quantity}</IconButton>
        <IconButton
          //onClick={this.add}
        >
          +
        </IconButton>
      </div>
    )
  }
}

// Add style
const SubstringDetailsView = withStyles(styles, {
  withTheme: true
})(SubstringDetailsComponent)
