import { StyleSheet, View, Button } from 'react-native';
import { startMyId, useListener } from 'react-native-myid';

export default function App() {
  const { code, error, success } = useListener();
  if (success) {
    console.log(code, 'code');
  } else {
    console.log(error, 'error');
  }

  return (
    <View style={styles.container}>
      <Button
        title="call native"
        onPress={() => {
          startMyId({
            clientId: 'client_id',
            clientHash: 'client_hash',
            clientHashId: 'client_hash_id',
            lang: 'EN', // EN, UZ, RU, KY
            type: 'DEBUG', // DEBUG, PRODUCTION
            withBirthDate: 'DD.MM.YYYY',
            withPassportData: 'AA*******',
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
