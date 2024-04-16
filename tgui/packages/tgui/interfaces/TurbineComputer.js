import { useBackend } from '../backend';
import { Button, LabeledList, Section } from '../components';
import { formatSiUnit } from '../format';
import { Window } from '../layouts';

export const TurbineComputer = (props, context) => {
  const { act, data } = useBackend(context);
  const operational = Boolean(
    data.compressor &&
      !data.compressor_broke &&
      data.turbine &&
      !data.turbine_broke
  );
  return (
    <Window width={310} height={180}>
      <Window.Content>
        <Section
          title="Status"
          buttons={
            <>
              <Button
                icon={data.online ? 'power-off' : 'times'}
                content={data.online ? 'Online' : 'Offline'}
                selected={data.online}
                disabled={!operational}
                onClick={() => act('toggle_power')}
              />
              <Button
                icon="sync"
                content="Reconnect"
                onClick={() => act('reconnect')}
              />
            </>
          }
        >
          {(!operational && (
            <LabeledList>
              <LabeledList.Item
                label="Compressor Status"
                color={
                  !data.compressor || data.compressor_broke ? 'bad' : 'good'
                }
              >
                {data.compressor_broke
                  ? data.compressor
                    ? 'Offline'
                    : 'Missing'
                  : 'Online'}
              </LabeledList.Item>
              <LabeledList.Item
                label="Turbine Status"
                color={!data.turbine || data.turbine_broke ? 'bad' : 'good'}
              >
                {data.turbine_broke
                  ? data.turbine
                    ? 'Offline'
                    : 'Missing'
                  : 'Online'}
              </LabeledList.Item>
            </LabeledList>
          )) || (
            <LabeledList>
              <LabeledList.Item label="Turbine Speed">
                {data.rpm} RPM
              </LabeledList.Item>
              <LabeledList.Item label="Internal Temp">
                {data.temp} K
              </LabeledList.Item>
              <LabeledList.Item label="Internal Pressure">
                {formatSiUnit(data.pressure * 1000, 1, 'Pa')}
              </LabeledList.Item>
              <LabeledList.Item label="Generated Power">
                {data.power}
              </LabeledList.Item>
            </LabeledList>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
