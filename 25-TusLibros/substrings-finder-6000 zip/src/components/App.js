const catalog = [
  {
      title: 'Iliada',
      isbn: '1111',
      author: 'Homer',
      image: 'https://images-na.ssl-images-amazon.com/images/I/51l2fBXLWZL._SX331_BO1,204,203,200_.jpg',
  },
  {
      title: 'Eneida',
      isbn: '2222',
      author: 'Virgil',
      image: 'http://fundalma.org.ar/images/La-Eneida_thumb.jpg',
  },
  {
      title: 'Introduction to Algorithms',
      isbn: '3333',
      author: 'Thomas H. Cormen',
      image: 'https://images-na.ssl-images-amazon.com/images/I/51rPLfOvqxL._SX376_BO1,204,203,200_.jpg',
  },
  {
      title: '1984',
      isbn: '4444',
      author: 'George Orwell',
      image: 'https://images-eu.ssl-images-amazon.com/images/I/51ueoexgYqL.jpg',
  },
  {
      title: 'Odisea',
      isbn: '5555',
      author: 'Homer',
      image: 'https://biblok.es/images/products/Selecta/Cubierta_LA_ODISEA.jpg',
  },
]

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: "/",
      substrings: [],
      selectedSubstring: "",
      cartId: 0
    };
  }

  render() {
    let title = "Tus Libros"
    let content = "Where am I?"
    const router = {
      current: () => this.state.path,
      navigate: (path, state) => {
        // http://es6-features.org/#SpreadOperator
        this.setState({ ...state, path: path })
      }
    }

    if (this.state.path === "/") {
      content = (<StringInputView
        router={router}
      />)
    } else if (this.state.path === "/catalog") {
        content = (<SubstringsView
        router={router}
        cartId={this.state.cartId}
        catalog={catalog}
      />)
    } else if (this.state.path === "/cart") {
        content = (<SubstringsView
        router={router}
        cartId={this.state.cartId}
        cartView
        catalog={catalog}
      />)
    } else if (this.state.path === "/details") {
      content = (<SubstringDetailsView
        router={router}
        item={this.state.item}
        quantity={this.state.quantity}
        cartId={this.state.cartId}
      />)
    } else if (this.state.path === '/checkout') {
      content = (
        <CheckoutView
          ticket={this.state.ticket}
          catalog={catalog}
        />
      )
    } else if (this.state.path === '/history') {
      content = (
        <HistoryView
          user={this.state.user}
          catalog={catalog}
        />
      )
    }
    return (
      <div>
        <MyToolBar
          title={title}
          router={router}
          cartId={this.state.cartId}
        />
        <Container maxWidth="sm">
          <div style={{ marginTop: 24, }}>
            {content}
          </div>
        </Container>
      </div>
    );
  }
}
