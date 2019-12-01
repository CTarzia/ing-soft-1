class CheckoutComponent extends React.Component {
    constructor(props) {
      super(props)
  
      this.state = {
        
      }
    }

    calcTotal = () => {
        const total = this.props.ticket.reduce((accum, curr) => {
              return accum + curr[2]
          }, 0)
        return total
    }

    getTitle = (row) => {
        const catalog = this.props.catalog
        const index = catalog.findIndex((i) => {
            return i.isbn == row[0]
        })

        return index > -1 ? catalog[index].title : ''
    }

    render() {
      const {
        // router,
        classes,
        ticket
      } = this.props
  
      const {
        loading,
        error,
      } = this.state
  
      if (loading) return <div>Loading...</div>
      return (
        <div>
          <Table className={classes.table} aria-label="simple table">
            <TableHead>
                <TableRow>
                    <TableCell>Titulo</TableCell>
                    <TableCell>ISBN</TableCell>
                    <TableCell align="right">Cantidad</TableCell>
                    <TableCell align="right">Precio</TableCell>
                </TableRow>
            </TableHead>
            <TableBody>
            {ticket.map(row => (
                <TableRow key={row[0]}>
                <TableCell component="th" scope="row">
                    {this.getTitle(row)}
                </TableCell>
                <TableCell align="left">{row[0]}</TableCell>
                <TableCell align="right">{row[1]}</TableCell>
                <TableCell align="right">{row[2]}</TableCell>
                </TableRow>
            ))}
            </TableBody>
            <TableFooter>
                <TableRow key={'total'}>
                <TableCell component="th" scope="row">
                    {'Total'}
                </TableCell>
                <TableCell align="left"></TableCell>
                <TableCell align="left"></TableCell>
                <TableCell align="right">{this.calcTotal()}</TableCell>
                </TableRow>
            </TableFooter>
        </Table>
        </div>
      )
    }
  }
  
  // Add style
  const CheckoutView = withStyles(styles, {
    withTheme: true
  })(CheckoutComponent)
  