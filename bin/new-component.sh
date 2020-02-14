#!/usr/bin/env bash

if [ -e $1 ]
then
  echo "File $1 already exists!"
else
  mkdir $1;
  storybook($1)
fi

storybook(name) {
  echo """
    import React from 'react';
    import { storiesOf } from '@storybook/react';

    import $name from './';

    storiesOf('Components', module)
      .add('$name', () => (
        <$name />
      ));
  """ >> $1/stories.js
}

component() {
  echo """
    import * as React from 'react';

    import * as styles from './styles.scss';

    type Props = {};

    const #: React.FunctionComponent<Props> = () =>
        <div className={styles.container}></div>
    );

    export default #;
  """
}

styles() {
  echo """
    @import '~styles/variables';

    .container {}
  """
}
