import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { EnvironmentVariables, validate } from './config/env-validation';

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: '.env',
      isGlobal: true,
      validationSchema: EnvironmentVariables,
      validate,
    }),
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
