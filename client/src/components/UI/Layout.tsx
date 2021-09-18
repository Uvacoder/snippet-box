interface Props {
  children: JSX.Element | JSX.Element[];
}

export const Layout = (props: Props): JSX.Element => {
  return (
    <div className='container'>
      <div className='row pt-4'>{props.children}</div>
    </div>
  );
};
