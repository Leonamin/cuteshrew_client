import 'package:cuteshrew/core/data/dto/posting_create_dto.dart';
import 'package:cuteshrew/core/data/mapper/mapper.dart';
import 'package:cuteshrew/core/domain/entity/posting_create_entity.dart';

class PostingCreateMapper
    extends Mapper<PostingCreateEntity, PostingCreateDTO> {
  @override
  PostingCreateDTO map(PostingCreateEntity object) {
    return PostingCreateDTO(
      title: object.title,
      body: object.body,
      isLocked: object.isLocked,
      password: object.password,
    );
  }
}
