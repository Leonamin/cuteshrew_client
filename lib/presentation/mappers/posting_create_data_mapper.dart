import 'package:cuteshrew/core/domain/entity/posting_create_entity.dart';
import 'package:cuteshrew/presentation/data/posting_create_data.dart';
import 'package:cuteshrew/presentation/mappers/data_mapper.dart';

class PostingCreateDataMapper
    extends DataMapper<PostingCreateData, PostingCreateEntity> {
  @override
  PostingCreateEntity map(PostingCreateData object) {
    return PostingCreateEntity(
      title: object.title,
      body: object.body,
      isLocked: object.isLocked,
      password: object.password,
    );
  }
}
