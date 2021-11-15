import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import {
  FastifyAdapter,
  NestFastifyApplication,
} from '@nestjs/platform-fastify';

import { ConfigService } from '@nestjs/config';
import { Logger } from '@nestjs/common';
import { Server } from 'http';

async function bootstrap() {
  const app = await NestFactory.create<NestFastifyApplication>(
    AppModule,
    new FastifyAdapter({ logger: true }),
  );

  const configService: ConfigService = app.get<ConfigService>(ConfigService);

  const port = configService.get<number>('PORT');

  await app.listen(port).then((server: Server) =>
    Logger.log(
      {
        listening: server.listening,
        addressInformation: server.address(),
      },
      'ApplicationBootstrap',
    ),
  );
}
bootstrap();
