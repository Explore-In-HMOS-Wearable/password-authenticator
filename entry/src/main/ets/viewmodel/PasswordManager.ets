import Password from './PasswordModel';

@ObservedV2
export class PasswordManager {
  @Trace password: Password[] = [
    new Password('Zyntra'),
    new Password('Lunovia'),
    new Password('Krynote'),
    new Password('Veltrix'),
    new Password('Osmira'),
    new Password('Drofio'),
    new Password('Nubelio'),
    new Password('Clyver')
  ]
  static _instance: PasswordManager;

  static instance() {
    if (!PasswordManager._instance) {
      PasswordManager._instance = new PasswordManager()
    }
    return PasswordManager._instance
  }
}


