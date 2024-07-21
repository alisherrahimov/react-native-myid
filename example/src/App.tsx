import { StyleSheet, View, Button } from 'react-native';
import { startMyId, useListener } from 'react-native-myid';

export default function App() {
  const { code, error, success } = useListener();
  if (success) {
    console.log(code);
  } else {
    console.log(error);
  }

  return (
    <View style={styles.container}>
      <Button
        title="call native"
        onPress={() => {
          startMyId({
            clientId: 'clientId',
            clientHash: 'clientHash',
            clientHashId: 'clientHashId',
            lang: 'EN',
          });
        }}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
